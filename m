Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTEXRwu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 13:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbTEXRwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 13:52:50 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:34498 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262703AbTEXRws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 13:52:48 -0400
Date: Sat, 24 May 2003 19:06:37 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Gutko <gutko@poczta.onet.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-RC2 Nforce2 AGP patch
Message-ID: <20030524180637.GA14838@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Gutko <gutko@poczta.onet.pl>, linux-kernel@vger.kernel.org
References: <3ECFA5F9.6060906@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ECFA5F9.6060906@poczta.onet.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 24, 2003 at 07:03:53PM +0200, Gutko wrote:
 > Same again but with proper topic
 > Sorry for this
 > Gutko
 > ----------
 > 
 > Hello,
 > This is patch against 2.4.21-rc2 adding Nvidia Nforce1/Nforce2 AGP 
 > chipset support.It worked very good on  2.4.21-rc2-ac3. I found this 
 > patch here : http://etudiant.epita.fr:8000/~nonolk/nforce-agp.diff
 > 
 > Don't know who ported it from 2.5.69, however I know this address above 
 > belongs to author of this patch

This is based on an old backport, and has at least one bug in it.
(It must use its own insert/remove, or you get problems with 32MB
 apertures).


		Dave

