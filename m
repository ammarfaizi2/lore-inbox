Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWAXXPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWAXXPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 18:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWAXXPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 18:15:20 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:47114 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1750803AbWAXXPT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 18:15:19 -0500
Date: Tue, 24 Jan 2006 23:14:09 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: dtor_core@ameritech.net
Cc: Al Viro <viro@ftp.linux.org.uk>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export symbols so CONFIG_INPUT works as a module
Message-ID: <20060124231409.GA29982@deprecation.cyrius.com>
References: <20060124181945.GA21955@deprecation.cyrius.com> <20060124183432.GA27917@redhat.com> <20060124184114.GS27946@ftp.linux.org.uk> <d120d5000601241508l1a93aae7ubdf8206209be405c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000601241508l1a93aae7ubdf8206209be405c@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [2006-01-24 18:08]:
> > More interesting question: is pis^H^H^Hsysfs interaction in there safe for
> > modular code?
> 
> The core should be safe, at least I was trying to make it this way, so
> if you see something wrong - shout. Locking is another question
> though...

So do you want an updated patch using _GPL to export the symbols or to
change CONFIG_INPUT to boolean?
-- 
Martin Michlmayr
http://www.cyrius.com/
