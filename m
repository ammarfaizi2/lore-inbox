Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWDYE5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWDYE5r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 00:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWDYE5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 00:57:46 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:6178 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751384AbWDYE5q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 00:57:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qL954pAGMDrSg9H+Rh5X99HREmBmikDUl9amH2+hbHPz1jVqMDME+n615a2rJselBDusqjyiFpRX+EwauwG8CYqec9kVCvKmlBdO8l3nBBSpRRFXwDqoZi3SRLl08gcKkQ8ceB2ZbG2Wmd5BPGebN1awYVHosxWs1sJ4FfSxIp4=
Message-ID: <4ae3c140604242157k26f39f71qcf6eed811f1e2d8@mail.gmail.com>
Date: Tue, 25 Apr 2006 00:57:45 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: question about nfs_execute_read: why do we need to do lock_kernel?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This question may be dumb. But I am curious why in nfs_execute_read()
function, rpc_execute  is bracketed with lock_kernel() and
unlock_kernel()?

Thanks in advance for your help!

xin
