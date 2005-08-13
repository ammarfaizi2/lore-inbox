Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbVHMRQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVHMRQn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 13:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVHMRQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 13:16:43 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:21496 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S932117AbVHMRQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 13:16:42 -0400
Message-ID: <42FE2B0A.2010305@austin.rr.com>
Date: Sat, 13 Aug 2005 12:16:58 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sending selected git changesets from middle of set of cloned tree
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way to send to mainline requests to pick up selected 
changesets from the middle of a git tree (another git tree on kernel.org 
in this case)?

I have two changsets (both one line fixes, but reasonably important ones)

    
http://www.kernel.org/git/?p=linux/kernel/git/sfrench/cifs-2.6.git;a=commit;h=f4cfd69cf349dd27e00d5cf804b57aee04e059c2

and
             
http://www.kernel.org/git/?p=linux/kernel/git/sfrench/cifs-2.6.git;a=commit;h=ef6724e32142c2d9ca252d423cacc435c142734e

without sending the whole tree (which includes another eight changesets 
some before and some after)?   After testing last week at the cifs 
plugfest, I would like to send these two in particular ASAP but want to 
wait on the other eight since it is so late in the rc cycle for 
mainline, and if I send them as diff/patches then I presumably would 
lose the changeset comments.

Is there a way to do a test committ against another git tree of a 
particular changeset in the middle of one of my trees?


Is there a way to update the comment field of a changeset without 
undoing the whole tree and reapplying each changeset?  This comes up a 
lot when someone opens a bugzilla bug number, after a fix for the 
problem has already been applied to the git tree.  It also would have 
helped once when I wanted to fix the signed-off line which was 
accidently left off without backing the whole set of later changes out 
and reapplying the changeset.
