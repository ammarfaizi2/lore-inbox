Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262893AbVGNEEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbVGNEEj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 00:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbVGNEEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 00:04:38 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:28574 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262887AbVGNEEh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 00:04:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BrPLAfEVB5QXsSSoSL7FeSobSRCFJZI5gFoHiV1nVWxXGAARTjcE2PQzz6iWa9oRhANYJ8g/0Kk3YZ8rBUWMF2HOSIqhzvfEM6nAkhoYxJ6q0lnS/o9Jg4erkRd79vRGstQc5uikBL2o0p6Vaf29RA/S5c+TF98c0s3e2O283lY=
Message-ID: <21d7e99705071321044c216db4@mail.gmail.com>
Date: Thu, 14 Jul 2005 14:04:37 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: moving DRM header files
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'd like to move the interface DRM header files (drm.h and *_drm.h)
somewhere more useful and also more "user-space" visible, (i.e. so
kernel-headers could start picking them up.)

I'm thinking include/linux/drm/
but include/linux would also be possible.

Any suggestions or ideas?

Dave.
