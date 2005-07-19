Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVGSObM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVGSObM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 10:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVGSObL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 10:31:11 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:22099 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261381AbVGSObL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 10:31:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JjnZRiDMuUSmeA4mNGUgrrOTtv6VmYADiEDBv+F2AN5CEDVoPAOZ29pd6MHyBoDQoQBo4n10ZVmtNW9V9/hATXbdnRInSVtOWoeaBOehnZUY9fuUp6MNISPQzTsmDEaoAiMVJhBXCm4AFU1/hDwEv/Ryio2373XdNe/3UmBRhsg=
Message-ID: <5f83f60f05071907313ad3b186@mail.gmail.com>
Date: Tue, 19 Jul 2005 20:01:10 +0530
From: Vivek Dasgupta <vivek.dasgupta@gmail.com>
Reply-To: Vivek Dasgupta <vivek.dasgupta@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: function to zero out module ref count so module can be unloaded in 2.6 kernel?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4 kernel one could check MOD_IN_USE and repeatedly call
MOD_DEC_USE_COUNT until the ref count drops to zero.

Is there a function in 2.6 kernel that would zero out the ref count so
that module can be unloaded ?

Need to implement ioctl for a driver to zero out the ref count.

Thanks
Vivek
