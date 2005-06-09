Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVFILbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVFILbn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 07:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVFILbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 07:31:43 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:56742 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261322AbVFILbm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 07:31:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=S0v6BmTIdZzoJODND0QgwXPAwWhkM+CmPHfRpMxB5rn8LkRWl6ApAqDcJ3sINtOOYNb6sC2+RfqVKCBUpb1pvkfmhtyUXmCbi809W+mjuVOilWnOuplLQ3AHJBkleDNTz0iD8BAb+/KsRIcv275a2HwdFl9Ys6xzL/FCEx7pQE0=
Message-ID: <2cd57c90050609043125bd3e1f@mail.gmail.com>
Date: Thu, 9 Jun 2005 19:31:41 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: unexport and static __mntput()
Cc: bunk@stusta.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I don't see any reasons that modules should call __mntput.
And it's only called by mntput(). Or anyone knows any outer code depends on it?

Adrian, a patch unexport and static it?

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
