Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268812AbUHLWHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268812AbUHLWHA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268817AbUHLWG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:06:59 -0400
Received: from mail.tmr.com ([216.238.38.203]:33298 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268812AbUHLWGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:06:41 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Thu, 12 Aug 2004 18:10:21 -0400
Organization: TMR Associates, Inc
Message-ID: <cfgpa6$gu2$1@gatekeeper.tmr.com>
References: <200408091412.i79EC7iR010554@burner.fokus.fraunhofer.de><200408091412.i79EC7iR010554@burner.fokus.fraunhofer.de> <1092061265.4383.5183.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1092348039 17346 192.168.12.100 (12 Aug 2004 22:00:39 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <1092061265.4383.5183.camel@hades.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On Mon, 2004-08-09 at 16:12 +0200, Joerg Schilling wrote:
> 
>>If you are right, why then is SuSE removing the warnings in cdrecord
>>that are there to tell the user that cdrecord is running with insufficient 
>>privilleges?
> 
> 
> Because those warnings are bogus, put there by someone who likes to
> complain about things that are not _really_ a problem?

Actually they are a problem on a loaded system, it's just that 
developers seem to run system with enough power to avoid the issues. And 
if you have a system using burn-free all the time you do use more track 
and the occasional device won't read it.

If someone would note the capabilities needed to allow these things 
maybe jrg would have one less thing to complain about.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
