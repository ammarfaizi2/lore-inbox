Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbTDQOXV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTDQOXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:23:21 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40646
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261530AbTDQOXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:23:20 -0400
Subject: Re: bio too big device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Anders Larsson <anders@dio.jll.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030416183139.M18348@gw>
References: <20030416172122.M65357@gw> <20030416181944.M32238@gw>
	 <20030416183139.M18348@gw>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050586615.31412.43.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Apr 2003 14:36:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-16 at 19:32, Anders Larsson wrote:
> Hi got this probb with this 
> 
> Apr 16 16:31:23 cab kernel: bio too big device ide3(34,65) (256 > 255)
> Apr 16 16:38:44 cab kernel: bio too big device ide3(34,1) (256 > 255)

Known bug in raid0 on the 2.5.x kernels still. 

