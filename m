Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTFDK4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 06:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTFDK4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 06:56:50 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15747
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263201AbTFDK4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 06:56:50 -0400
Subject: Re: Re:2.5.70-mm4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vitalis Tiknius <vt@vt.fermentas.lt>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200306041308.24120.vt@vt.fermentas.lt>
References: <200306041308.24120.vt@vt.fermentas.lt>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054721542.9359.89.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Jun 2003 11:12:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-04 at 12:08, Vitalis Tiknius wrote:
> re. cdrom mount problem: so far, so good with all combinations.
> 
> vesafb problem: does not work with memory >1Gb.

There is a more complete fix in the -ac tree. The one you have there is
ought on memory allocation by a factor of eight and doesn't allow for
double buffering and catching some corner cases.

The 2.4 one has been evolving somewhat over time

