Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUHJISy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUHJISy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUHJIS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:18:26 -0400
Received: from main.gmane.org ([80.91.224.249]:9127 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261875AbUHJIQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:16:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Tue, 10 Aug 2004 10:16:19 +0200
Message-ID: <yw1xisbrflws.fsf@kth.se>
References: <1092082920.5761.266.camel@cube> <cone.1092092365.461905.29067.502@pc.kolivas.org>
 <1092099669.5759.283.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 161.80-203-29.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:uYHrW4p4uGqGGpW/6oEH1rrmIaE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sf.net> writes:

>> Last time I gave 
>> superuser privilege to cdrecord it locked my machine - clearly it wasn't 
>> rt_task safe.
>
> So, you've been working on the scheduler anyway...
> An option to reserve some portion of CPU time for
> emergency use (say, 5% after 1 second has passed)
> would let somebody get out of this situation.

Another option would be an Alt-Sysrq-something that lowered all RT
processes to normal levels.

-- 
Måns Rullgård
mru@kth.se

