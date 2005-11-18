Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVKRPj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVKRPj4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 10:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVKRPj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 10:39:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20655 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932074AbVKRPjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 10:39:55 -0500
Date: Fri, 18 Nov 2005 15:39:37 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: linux-kernel@vger.kernel.org, jblunck@suse.de
Subject: Re: [PATCH] device-mapper snapshot: bio_list fix
Message-ID: <20051118153937.GQ26394@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	"Alexander E. Patrakov" <patrakov@ums.usu.ru>,
	linux-kernel@vger.kernel.org, jblunck@suse.de
References: <20051118145547.GK11878@agk.surrey.redhat.com> <437DF42B.8000008@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437DF42B.8000008@ums.usu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 08:32:59PM +0500, Alexander E. Patrakov wrote:
> Could you please tell how to reproduce this oops 

Try creating/removing multiple snapshots of the same device while
I/O is going on.

Alasdair
-- 
agk@redhat.com
