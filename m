Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267991AbTAIAJl>; Wed, 8 Jan 2003 19:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267725AbTAIAJb>; Wed, 8 Jan 2003 19:09:31 -0500
Received: from air-2.osdl.org ([65.172.181.6]:26291 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267991AbTAIAGM>;
	Wed, 8 Jan 2003 19:06:12 -0500
Subject: Re: unix_getname buglet - > 2.5.4(?)
From: Andy Pfiffer <andyp@osdl.org>
To: Michael Meeks <michael@ximian.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       evolution <evolution-hackers@ximian.com>, orbit <orbit-list@gnome.org>,
       rml@tech9.net, eblade@blackmagik.dynup.net, tmolina@cox.net
In-Reply-To: <1041941192.25619.293.camel@michael.home>
References: <1041941192.25619.293.camel@michael.home>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Jan 2003 16:14:55 -0800
Message-Id: <1042071299.12158.106.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-07 at 04:06, Michael Meeks wrote:
> Hi there,
> 
> 	Evolution is non-functioning on recent 2.5.X kernels, due to
> mal-performance in getpeername => net/unix/af_unix.c (unix_getname),
> where it seems we switch 'sk' on 'peer', but not the (previously)
> typecast pointer to it; this fixes it.
> 
<snip>
> 	Thanks Joaquim Fellmann (AFAIR) who chased this down to bitkeeper
> changeset 1.262.2.2. Sadly I didn't have time to read the rest of that
> changeset to see if the mistake pops up elsewhere as well. Please CC me
> with replies, not on linux-kernel.
> 
> 	HTH,
> 
> 		Michael Meeks.


http://marc.theaimsgroup.com/?l=linux-kernel&m=103462833225515&w=2

Thanks for the fix!

Keep up the great work, Ximian dudes and dudettes.


