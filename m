Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbTFPIkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 04:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTFPIkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 04:40:42 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:12479 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263624AbTFPIki
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 04:40:38 -0400
Date: Mon, 16 Jun 2003 14:27:27 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Seifert Guido, gse" <Guido.Seifert@pentapharm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5.71 cannot unmount nfs
Message-ID: <20030616085727.GA1331@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <0557B834CB410E4EB692BC78504D4C2C02F3EC@dc0011.pefade.pefa.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0557B834CB410E4EB692BC78504D4C2C02F3EC@dc0011.pefade.pefa.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 08:23:48AM +0000, Seifert Guido, gse wrote:
> 
> Sorry for the incomplete and unprofessional bugreport, I don't have more
> info. 
> I tried Kernel 2.5.71. Everything seems to work fine until I shut down
> or try to 
> unmount a mountend nfs filesystem. For several minutes nothing happens, 
> then I get something what looks like a backtrace from the nfs related
> code 
> section. Unfortunately there is nothing in the log files afterwards. 
> G. 

Does this patch fix your problem ?

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.71/2.5.71-mm1/broken-out/rpc-depopulate-fix.patch

Thanks
Dipankar
