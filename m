Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbTJDFSK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 01:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTJDFSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 01:18:10 -0400
Received: from mail1.dac.neu.edu ([129.10.1.75]:41745 "EHLO mail1.dac.neu.edu")
	by vger.kernel.org with ESMTP id S261836AbTJDFSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 01:18:08 -0400
Message-ID: <3F7E57E9.8070904@ccs.neu.edu>
Date: Sat, 04 Oct 2003 01:17:29 -0400
From: Stan Bubrouski <stan@ccs.neu.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030917
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix oops after saving image
References: <20031002203906.GB7407@elf.ucw.cz> <Pine.LNX.4.44.0310031433530.28816-100000@cherise> <20031003223352.GB344@elf.ucw.cz>
In-Reply-To: <20031003223352.GB344@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> + *    Note: The buffer we allocate to use to write the suspend header is
> + *    not freed; its not needed since system is going down anyway
> + *    (plus it causes oops and I'm lazy^H^H^H^Htoo busy).
> + */

Too lazy to properly fix your comment as well.

-sb


