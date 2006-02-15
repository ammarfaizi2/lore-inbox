Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030624AbWBODj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030624AbWBODj2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 22:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030625AbWBODj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 22:39:28 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:1924 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030624AbWBODj1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 22:39:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gN/gSJL7t0DLOzEFhUYnRyBWGmFXDTh9fqO/gaSpvYcIHlpljPzEtULnSDTW6IPYJydGVSTiHgd8FM7KGdO1bpMELT81Sd2YmCFV6pdjB5zDM3nYn9VoYjsAVFXduQ2a/G/rpA8NtNG7/oprI0YCmvtpXQk5K9vrGp7QtgLNopI=
Message-ID: <67029b170602141939v4791ac72l@mail.gmail.com>
Date: Wed, 15 Feb 2006 11:39:26 +0800
From: Zhou Yingchao <yingchao.zhou@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] kretprobe instance recycled by parent process
In-Reply-To: <67029b170602141936v69b85832q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43F3059A.9070601@linux.intel.com>
	 <67029b170602141936v69b85832q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/2/15, bibo mao <bibo_mao@linux.intel.com>:
> When kretprobe probe schedule() function, if probed process exit then
> schedule() function will never return, so some kretprobe instance will
> never be recycled. By this patch the parent process will recycle
> retprobe instance of probed function, there will be no memory leak of
> kretprobe instance. This patch is based on 2.6.16-rc3.

Is there any process which can exit without go through the do_exit() path?
--
Yingchao Zhou
***********************************************
 Institute Of Computing Technology
 Chinese Academy of Sciences
 Tel(O) : 010-62613792-28
***********************************************


--
Yingchao Zhou
***********************************************
 Institute Of Computing Technology
 Chinese Academy of Sciences
 Tel(O) : 010-62613792-28
***********************************************
