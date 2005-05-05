Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVEEHIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVEEHIj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 03:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVEEHIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 03:08:39 -0400
Received: from netblock-66-159-231-38.dslextreme.com ([66.159.231.38]:54758
	"EHLO mail.cavein.org") by vger.kernel.org with ESMTP
	id S261921AbVEEHIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 03:08:38 -0400
Date: Thu, 5 May 2005 00:08:34 -0700 (PDT)
From: Richard A Nelson <cowboy@cavein.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm3
In-Reply-To: <20050504221057.1e02a402.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0505050003280.8204@hygvzn-guhyr.pnirva.bet>
References: <20050504221057.1e02a402.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2005, Andrew Morton wrote:

> - -mm seems unusually stable at present.

I have, on the home box, an issue with alsa
	2.6.12-rc3 works fine
	2.6.12-rc3-rc3, and rc2-xx(forgot) fail

There are unresolved symbols loading snd_via82xx

The box at work is hung at the moment, so I'll check it in the morning,
but it was having problems with
	* bad skb fields on lo
	* ingress filtering was issuing errors

I'll append more in the morning when I can reboot the box
-- 
Rick Nelson
How do I type "for i in *.dvi do xdvi i done" in a GUI?
(Discussion in comp.os.linux.misc on the intuitiveness of interfaces.)
