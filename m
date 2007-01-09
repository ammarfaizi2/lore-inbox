Return-Path: <linux-kernel-owner+w=401wt.eu-S1750774AbXAIAbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbXAIAbQ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 19:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbXAIAbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 19:31:16 -0500
Received: from smtp106.biz.mail.mud.yahoo.com ([68.142.200.254]:43658 "HELO
	smtp106.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750774AbXAIAbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 19:31:15 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jan 2007 19:31:15 EST
X-YMail-OSG: cEFeg8oVM1kRnwi8RwUtHD7RaX6TjsCHZbZLi.HtoRsLFeigCFf_Rrl2qpWPCYgFdlwA0ZZ.piU5J0.3WbLq4pcCL_q260J8u_afg4l2jge4lAdpsJ03nhTIa5hUSFT27nK0Cel9VdX1ANHoQnnNUGCbKjFT.w8L33FZYP99HD.TZDUb6WBOupOZzE_a
Message-ID: <45A2E19F.4070307@metricsystems.com>
Date: Mon, 08 Jan 2007 16:28:15 -0800
From: John Clark <jclark@metricsystems.com>
Organization: Metric Systems, Inc.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Strange ethN numbering problem.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a system which has one Intel Ethernet 1 Gb interface, and 4 'Marvel', 
interfaces,
during kernel initialization the interfaces indicate they have 'normal' 
ethernet ethN names,
ie, eth0, eth1, eth2, eth3, eth4, eth5 are reported from the 'dmesg' output.

However, when the system comes up and attempt to do an ifconfig, the 
'ethN' numbers
have changed to a some what intermengled seriese starting with eth6... 
eth10.

I have never seen this sort of problem before, and so I have no clue 
what is causing
the later changes in the numbering scheme.

Does anyone have any idea where to look.

Thanks
John Clark

