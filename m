Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWG3Ryb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWG3Ryb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWG3Ryb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:54:31 -0400
Received: from ns2.suse.de ([195.135.220.15]:45785 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932394AbWG3Rya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:54:30 -0400
From: Andi Kleen <ak@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Building external modules against objdirs
Date: Sun, 30 Jul 2006 19:49:41 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, agruen@suse.de
References: <200607301846.07797.ak@suse.de> <20060730175130.GA23665@mars.ravnborg.org>
In-Reply-To: <20060730175130.GA23665@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301949.41165.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Can you check that you really did a 'make prepare' in the relevant
> output directory. Previously only the make *config step was needed.

The output directory is a full build (configuration + make without any targets).
Is that not enough anymore? 

Anyways after a make prepare it seems to work - thanks - but I think that
should be really done as part of the standard build like it was in 2.6.17.

-Andi
