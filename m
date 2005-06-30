Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVF3LNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVF3LNP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 07:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVF3LNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 07:13:15 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:45638 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261494AbVF3LNN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 07:13:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NDs8ITard1KDqV1ldM5MFNYb22Ketn7IiJbu/j/ok6TOTMooHp0oBql3T73bWJwIUnXrAvjAFtx1VnM5Bid19ATzWY16LfmGRhUTZVyyatUHUKMJcWJiNXcZhwCTM6VQZKgyUF1LARq64C4e+7q6P1bQ4b42M35jJwqK/7rs3ak=
Message-ID: <dc849d8505063004136573e59e@mail.gmail.com>
Date: Thu, 30 Jun 2005 19:13:12 +0800
From: chengq <benbenshi@gmail.com>
Reply-To: chengq <benbenshi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: route reload after interface restart
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

Routes relate to ethX were deleted from kernel after i shutdown ethX
(ifconfig ethX down),but after i start ethX (ifconfig ethX
XXX.XXX.XXX.XXX up ),  deleted  routes were not re-add to kernel .

Is there any patch or daemon can do this  for me, after i restart
ethX,deleted rotues were re-added to kernel automatically.

regards
