Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWFSDrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWFSDrw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 23:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWFSDrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 23:47:52 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:28854 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750965AbWFSDrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 23:47:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=R3dziZ7Gbpe9GiWuqMv4VMYNZmc5cwE9olVzq7ysCP8xCTvKeTLdR0VnkCzYPHMk9mr4F9tjRC4Xj94z3KpF7/4TFoAe6uPsiFT90euQikUnpD3j4B2RVYE72uW9L/KiFDVxW1BF6PP9l+YcWbzB7eW+AHCFH/8onAmtMeISRuw=
Message-ID: <787b0d920606182047n62916655m5c88dc38e6b1ad72@mail.gmail.com>
Date: Sun, 18 Jun 2006 23:47:51 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org, samuel.thibault@ens-lyon.org
Subject: Re: emergency or init=/bin/sh mode and terminal signals
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault writes:

> The attached patch sets such session and controlling tty up, which fixes
> the issue. The unfortunate effect is that init might be killed if one
> presses control-C very fast after its start.

Doesn't the kernel protect process 1 from any signal
that it does not have a handler for?

I think there is no problem.
