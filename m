Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbSK0THE>; Wed, 27 Nov 2002 14:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbSK0THE>; Wed, 27 Nov 2002 14:07:04 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:47550 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S264686AbSK0THD>; Wed, 27 Nov 2002 14:07:03 -0500
Date: Wed, 27 Nov 2002 13:14:14 -0600 (CST)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: A Kernel Configuration Tale of Woe 
In-Reply-To: <12497.1038399540@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0211271310430.3864-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2002, Keith Owens wrote:

> Bullshit.  It was fully documented in kbuild 2.5.  Just because Kai
> dropped the docs when he stole bits from kbuild 2.5 does not make
> .force_default into an undocumented feature.

$ bk changes -r1.403.20.3
ChangeSet@1.403.20.3, 2002-06-05 19:40:54-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Additional config targets for testing
  
  This patch adds the following targets, which generate some configs
  useful for testing - which kind should be clear from the names:
  
  o allyesconfig
  o allmodconfig
  o allnoconfig
  o randconfig
  
  It also adds
  
  o defconfig
  
  which does the same as make oldconfig but uses the defaults for all
  new options without asking.
  
  The actual patch was done by Ghozlane Toumi, maintained in kbuild-2.5
  by Keith Owens, and extracted by Sam Ravnborg and patch@luckynet.dynu.com.

Don't you think accusing me of "stealing" from kbuild-2.5 is a bit 
harsh???

--Kai


