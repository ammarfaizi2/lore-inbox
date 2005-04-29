Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262853AbVD2Rkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbVD2Rkl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 13:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbVD2Rkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 13:40:41 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:35247 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S262853AbVD2Rki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 13:40:38 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: type argument in access_ok() macro
Date: Fri, 29 Apr 2005 19:40:13 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504291940.13634.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

what's with the 'type' argument of the access_ok() macro. As long as my kernel 
source browsing system lxr doesn't show something wrong, I'm pretty much sure 
that the type argument in access_ok() is not being used in any arch. Is this 
on purpose or has it become obsolete but nobody dared to break things by 
removing it? ... or probably it is some kernel magic :)?

Regards,
Boris.
