Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWDFDiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWDFDiW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 23:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWDFDiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 23:38:22 -0400
Received: from wproxy.gmail.com ([64.233.184.233]:18662 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751359AbWDFDiV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 23:38:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=G5873KYYUJOItyx/iDVZdDKkbaVkHjB9B6lupD+B3YJWIjiA28NWn+K4dOzt3JuSs8Gqpe2wokDPmCENxORDYX8F4CW5LLaAh9/dAg9hBmGPTt32irrcDG+cFQifMvgLrcRzuxCdUlKlBtbg4Tnuu4Ak1axJcYJOdoeORm8eg4o=
Message-ID: <787b0d920604052038i3a75bdb6ic0818d93805b881b@mail.gmail.com>
Date: Wed, 5 Apr 2006 23:38:20 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: wait4/waitpid/waitid oddness
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel prohibits:

1. WNOHANG on waitpid/wait4
2. __WALL on waitid

Why? I need both at once.
