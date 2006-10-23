Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWJWU3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWJWU3m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWJWU3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:29:41 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:63936 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751169AbWJWU3k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:29:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 8/13] KVM: vcpu execution loop
Date: Mon, 23 Oct 2006 22:29:41 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <453CC390.9080508@qumranet.com> <200610232141.45802.arnd@arndb.de> <453D230D.7070403@qumranet.com>
In-Reply-To: <453D230D.7070403@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610232229.41934.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 October 2006 22:16, Avi Kivity wrote:
> > This looks like you should simply put it into a .S file.
> >
> >  
>
> Then I lose all the offsetof constants down the line.  Sure, I could do
> the asm-offsets dance but it seems to me like needless obfuscation.

Ok, I see.

How if you pass &vcpu->regs and &vcpu->cr2 to the functions instead of 
kvm_vcpu?

	Arnd <>< 
