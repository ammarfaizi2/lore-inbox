Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTJMDvD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 23:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbTJMDvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 23:51:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:33173 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261368AbTJMDvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 23:51:01 -0400
Date: Sun, 12 Oct 2003 20:54:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: thunder7@xs4all.nl, vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: keyboard repeat speed went nuts since 2.6.0-test5, even in
 2.6.0-test6-mm4
Message-Id: <20031012205412.09410cc5.akpm@osdl.org>
In-Reply-To: <20031008082806.GA23340@ucw.cz>
References: <20031007203316.GA1719@middle.of.nowhere>
	<20031007204056.GB20844@ucw.cz>
	<20031008082346.GA1628@middle.of.nowhere>
	<20031008082806.GA23340@ucw.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> wrote:
>
> +static int __init atkbd_setup_softrepeat(char *str)
>  +{
>  +        int ints[4];
>  +        str = get_options(str, ARRAY_SIZE(ints), ints);
>  +        if (ints[0] > 0) atkbd_softrepeat = ints[1];
>  +        return 1;
>  +}
>   
>   __setup("atkbd_set=", atkbd_setup_set);
>   __setup("atkbd_reset", atkbd_setup_reset);
>  +__setup("atkbd_softrepeat=", atkbd_setup_softrepeat);

Could we please try to keep Documentation/kernel-parameters.txt in
sync with the code?

Thanks.
