Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264393AbTFKMHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 08:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbTFKMHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 08:07:13 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27818
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264393AbTFKMHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 08:07:11 -0400
Subject: Re: Misc 2.5 Fixes: cp-user-vicam
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dipankar@in.ibm.com
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
In-Reply-To: <20030611104823.GB3718@in.ibm.com>
References: <20030610100643.GB2194@in.ibm.com>
	 <20030610100746.GC2194@in.ibm.com> <20030610100905.GD2194@in.ibm.com>
	 <20030610100950.GE2194@in.ibm.com> <20030610101035.GF2194@in.ibm.com>
	 <20030610101121.GG2194@in.ibm.com> <20030610101318.GH2194@in.ibm.com>
	 <20030610101503.GI2194@in.ibm.com> <20030610101801.GJ2194@in.ibm.com>
	 <20030610102024.GK2194@in.ibm.com>  <20030611104823.GB3718@in.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055333897.2083.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jun 2003 13:18:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-11 at 11:48, Dipankar Sarma wrote:
> The patch I sent yesterday is bad, turns out I didn't enable vicam
> config option while compiling. Here is a replacement patch that
> actually compiles.

This looks odd. 2.5 unlike 2.4 video4linux has the wrapper copy the
structures in and out

