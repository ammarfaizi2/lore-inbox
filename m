Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWDUMxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWDUMxd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 08:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWDUMxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 08:53:32 -0400
Received: from web52910.mail.yahoo.com ([206.190.49.20]:50561 "HELO
	web52910.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932289AbWDUMxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 08:53:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Ng3RQU1qNGteml0gEtniN/AYmx9Ux+1+b/+dUEv8RVnJocwi6m4P6dOUiog5VY49gylqgPunSvl36Fo7obS2J9zuVVjPlogbe/5gFy5Dxtziqe45mXk5/XLi4tjlhCyUQ16/42NsGmKMAhlaLTSGH7itP2OCAWN4RLyQOLJGE/g=  ;
Message-ID: <20060421125329.4210.qmail@web52910.mail.yahoo.com>
Date: Fri, 21 Apr 2006 13:53:29 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: [patch 05/22] : Fix hotplug race during device registration
To: greg@kroah.com
Cc: patrakov@ums.usu.ru, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With reference to this patch:
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=2731570eba5b35a21c311dd587057c39805082f1;hp=dfb62998866ae2e298139164a85ec0757b7f3fc7;hb=9469d458b90bfb9117cbb488cfa645d94c3921b1;f=net/core/dev.c

Doesn't this patch introduce another bug when registration fails, because reg_state is left as
NETREG_REGISTERED?

Cheers,
Chris


Send instant messages to your online friends http://uk.messenger.yahoo.com 
