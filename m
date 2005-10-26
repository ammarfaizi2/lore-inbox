Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbVJZSet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVJZSet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 14:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbVJZSet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 14:34:49 -0400
Received: from c-67-180-160-189.hsd1.ca.comcast.net ([67.180.160.189]:5321
	"EHLO mtv-vpn-hw-jlan-2.corp.sgi.com") by vger.kernel.org with ESMTP
	id S964855AbVJZSes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 14:34:48 -0400
Message-ID: <435FCC36.6000304@engr.sgi.com>
Date: Wed, 26 Oct 2005 11:34:30 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Helsley <matthltc@us.ibm.com>
CC: Chris Wright <chrisw@osdl.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       Jay Lan <jlan@engr.sgi.com>, Erik Jacobson <erikj@sgi.com>,
       Jack Steiner <steiner@sgi.com>
Subject: Re: [ckrm-tech] Re: [PATCH 00/02] Process Events Connector
References: <1130285260.10680.194.camel@stark>	 <20051026003430.GA27680@kroah.com> <1130288437.10680.236.camel@stark>	 <20051026012216.GD5856@shell0.pdx.osdl.net>	 <1130290233.10680.262.camel@stark>	 <20051026014852.GE5856@shell0.pdx.osdl.net> <1130292802.10680.283.camel@stark>
In-Reply-To: <1130292802.10680.283.camel@stark>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley wrote:
>On Tue, 2005-10-25 at 18:48 -0700, Chris Wright wrote:
>  
>>* Matt Helsley (matthltc@us.ibm.com) wrote:
>>    
>>>	It seems to me that this is the consensus here and on LSE-Tech.
>>>This patch addresses the needs of ELSA and CKRM and is amenable to using
>>>the patches recently proposed on lse-tech to pull out the common piece.
>>>      
>>Sounds good.  What about the SGI needs (for PAGG)?  They just posted
>>pnotify pretty recently.   Or is that what you mean by consensus and
>>possible use of 'task notifiers'?
>>    

Hi,

Jesse is no longer with SGI.

Please cc erikj(PAGG & task_notifier) and jlan(CSA) on discussion
related to process
event notifier.

Thanks!
- jay

>>thanks,
>>-chris
>>    
>
>	If this patch used pnotify it would be much more complicated and it
>would need to attach small pieces of data to each task. However there
>have been some alternative proposals. The 'task_notifier' patch posted
>by Jack Steiner was much closer to what this patch needs:
>http://marc.theaimsgroup.com/?l=lse-tech&m=112869558116290&w=2
>
>	'task_notifier' is smaller and easier to review but still requires
>per-task data that would complicate the Process Events Connector patch.
>There has been some discussion in the above thread on how to address the
>per-task data/notification needs of PAGG and the all-task notification
>needs of ELSA and CKRM.
>
>Cheers,
>	-Matt Helsley
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by the JBoss Inc.
>Get Certified Today * Register for a JBoss Training Course
>Free Certification Exam for All Training Attendees Through End of 2005
>Visit http://www.jboss.com/services/certification for more information
>_______________________________________________
>ckrm-tech mailing list
>https://lists.sourceforge.net/lists/listinfo/ckrm-tech
>  

