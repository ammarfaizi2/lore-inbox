Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422950AbWJFUwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422950AbWJFUwn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422951AbWJFUwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:52:43 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:22679 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422950AbWJFUwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:52:42 -0400
Subject: Re: [Alsa-devel] 2.6.19-rc1 boot failure--ops in mpu401_init?
From: Lee Revell <rlrevell@joe-job.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061006204358.GB18026@fieldses.org>
References: <20061006204358.GB18026@fieldses.org>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 16:53:13 -0400
Message-Id: <1160167993.17615.0.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 16:43 -0400, J. Bruce Fields wrote:
> I also probably won't have time to try a git-bisect in the next few
> days, though I could try it eventually if it'd help. 

Thanks for the report.  Problem is known and fixed in later releases.
See the LKML/alsa-devel thread "Driver core: Don't ignore error returns
from probing".

Lee

