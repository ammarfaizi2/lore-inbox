Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbTENOb0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbTENOb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 10:31:26 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:25293 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262341AbTENObZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 10:31:25 -0400
Date: Wed, 14 May 2003 15:44:43 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What exactly does "supports Linux" mean?
Message-ID: <20030514144443.GA7203@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Henning P. Schmiedehausen" <hps@intermeta.de>,
	linux-kernel@vger.kernel.org
References: <200305131114_MC3-1-38B0-3C13@compuserve.com> <yw1x3cjifutq.fsf@zaphod.guide> <b9timt$e3m$3@tangens.hometree.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9timt$e3m$3@tangens.hometree.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 02:09:33PM +0000, Henning P. Schmiedehausen wrote:

 > >From a user land perspective, only major Linux vendors or
 > organizations could enforce such a logo program, it would cost wads of
 > cash and it will really suck if you currently run the certification
 > process for Linux 2.5.102 for your driver and right before you're
 > done, 2.5.103 is released and you have to start all over again.

Certifying anything against a development series kernel is completely
pointless.  Breakage outside the driver itself could have adverse
affects. Example: For the last dozen or so kernels, the i845 AGP driver
crashed on exiting X. Turned out to be a VM bug.


		Dave

