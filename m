Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUHJIbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUHJIbC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUHJIbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:31:02 -0400
Received: from main.gmane.org ([80.91.224.249]:23207 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261239AbUHJIa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:30:59 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Tue, 10 Aug 2004 10:20:49 +0200
Message-ID: <yw1xekmfflpa.fsf@kth.se>
References: <1092082920.5761.266.camel@cube> <cone.1092092365.461905.29067.502@pc.kolivas.org>
 <1092099669.5759.283.camel@cube>
 <cone.1092113232.42936.29067.502@pc.kolivas.org>
 <1092106283.5761.304.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 161.80-203-29.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:YZUTtIELb1dkNSb2lELveCQuh8c=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sf.net> writes:

> I'm not about to burn CDs trying, but I do believe
> that "a ruined cd is likely" would be accurate if I
> were to keep busy with Mozilla and such. OpenOffice
> would surely ruin a cd. Light web browsing makes my
> mp3 player skip.
>
> Not all of us have hardware like you do. Encoding
> video is something I wouldn't bother to try, even
> without the CD burner going!

Encoding video is a typically CPU-bound task, unless your machine is
so fast that it saturates the disk bandwidth.  The scheduler should
give the encoding lower priority than the "interactive" CD burning.

-- 
Måns Rullgård
mru@kth.se

