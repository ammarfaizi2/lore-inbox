Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbWHHXrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWHHXrr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 19:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWHHXrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 19:47:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:57286 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030340AbWHHXrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 19:47:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AWLArwFZaPPOzy2Z6fPdYgpcQ2Za8b/grjW2jx1++n52r4m6u5RGiQimFCL+7lUkVU9jpF7Pom4wmJVuXm8SG7xH1hWKyOKgP+QHibT57xNNPYuzSPUIUa/tIkZ1/3Aqr8kP+ja+mCOMwqNFQkSbAMCT+dKSIcb4kWbTx4lcVLM=
Message-ID: <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
Date: Wed, 9 Aug 2006 01:47:39 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ext3 corruption
In-Reply-To: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a ~1TB filesystem that fails to mount, the message is:

EXT3-fs error (device loop0): ext3_check_descriptors: Block bitmap for
group 2338 not in group (block 1607003381)!
EXT3-fs: group descriptors corrupted !

A day before, it worked flawlessly.

What could have happened, and what's the best course of action?
