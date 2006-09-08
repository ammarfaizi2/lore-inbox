Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWIHN52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWIHN52 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 09:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWIHN52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 09:57:28 -0400
Received: from main.gmane.org ([80.91.229.2]:7640 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751119AbWIHN51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 09:57:27 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: re-reading the partition table on a "busy" drive
Date: Fri, 08 Sep 2006 16:56:19 +0200
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <45018493.9050207@flower.upol.cz>
References: <45004707.4030703@tls.msk.ru> <450105C0.2010603@flower.upol.cz> <Pine.LNX.4.61.0609080857090.30219@yvahk01.tjqt.qr> <20060908135858.GB14370@flower.upol.cz> <4501714F.9030709@tls.msk.ru> <Pine.LNX.4.61.0609081546260.25316@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Michael Tokarev <mjt@tls.msk.ru>
X-Gmane-NNTP-Posting-Host: 158.194.192.153
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <Pine.LNX.4.61.0609081546260.25316@yvahk01.tjqt.qr>
X-Image-Url: http://flower.upol.cz/~olecom/upol-cz.png
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>My anwser to this question: if it's so "pretty annoying", just let it be
>>>"yes, do as i said !", not more and not less, just most ;).
>>
>>Well, this whole question is already moot, as pointed out by Olaf.
>>Because kernel already supports add/delete single partition ioctls,
>>which is sufficient.  For my needs I already wrote a tiny hack which
>>compares /proc/partitions with the output of `sfdisk -d' and re-adds
>>anything which changed.  It should be possible to do the same with
>>parted instead of {sf,cf,f}disk without using that hack, but hell,
>>all those fdisks (parted included) sucks badly, each in its own way,
>>so all are being used for different parts of the task, including the
>>hack ;)
> 
> 
> So something should write the perfect utility. There are people on this 
> list capable of this, like we have seen with git :)

As far as i can see, most of such was actually started by Linus,
including linux.....

> Jan Engelhardt


-- 
-o--=O`C  /. .\   (+)
  #oo'L O      o    |
<___=E M    ^--    |  (you're barking up the wrong tree)

