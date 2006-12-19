Return-Path: <linux-kernel-owner+w=401wt.eu-S932724AbWLSJcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbWLSJcW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbWLSJcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:32:22 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:8296 "EHLO
	mtagate5.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932715AbWLSJcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:32:21 -0500
In-Reply-To: <20061219084248.GF4049@APFDCB5C>
Subject: Re: [PATCH] ehca: fix kthread_create() error check
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Christoph Raisch <raisch@de.ibm.com>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
Message-ID: <OFDC0390A9.656182FD-ONC1257249.00343930-C1257249.00346507@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Tue, 19 Dec 2006 10:32:16 +0100
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.5.5HF882 | September 26, 2006) at
 19/12/2006 10:32:18
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> The return value of kthread_create() should be checked by
> IS_ERR(). create_comp_task() returns the return value from
> kthread_create().
Good catch. Appreciate your help!
Regards
Nam

