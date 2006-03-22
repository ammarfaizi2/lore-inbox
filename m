Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWCVPk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWCVPk5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWCVPk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:40:56 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:42939 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751344AbWCVPk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:40:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=enhMy/OKM0+/2JSJ7YghsE/2jTYUNjCaKS/fl/viIS/ADijp1q/xiGcSvpmnSx/9HSze8NJXT/y4FGuMuVC+2w5wCTR8B3G0O2COfMqn07h3ZiMg4Qpq3IZRfCbXUK5lnFKjInINrUw/wmK2DN1FZGle26FoL1frtPgoyfS0v7c=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net, mikado4vn@gmail.com
Subject: Re: [uml-devel] Cannot debug UML
Date: Wed, 22 Mar 2006 16:40:49 +0100
User-Agent: KMail/1.8.3
Cc: stefano.melchior@openlabs.it, user-mode-linux-user@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <44215200.8020708@gmail.com> <20060322135015.GC8115@SteX> <44215B8F.6060400@gmail.com>
In-Reply-To: <44215B8F.6060400@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221640.50362.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 15:13, Mikado wrote:
> Stefano Melchior wrote:
> > On Wed, Mar 22, 2006 at 08:32:48PM +0700, Mikado wrote:
> > Hi Mikado,

> Debugging UML requires running it under TT mode. Normally I run UML
> under SKAS mode, everything is OK. I cannot get into GDB under SKAS mode
> whenever I use 'debug' option.

debug is an ugly trick for TT-only.

For SKAS mode use the normal debug sequence:

$ gdb vmlinux
(gdb) <set breakpoints, do what you want>
(gdb) run <params>

More info at the "debugging UML" link, "SKAS" subsection on the main site.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	
	
		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com
