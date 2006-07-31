Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWGaMgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWGaMgv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 08:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWGaMgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 08:36:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:22142 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932161AbWGaMgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 08:36:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=edUSDZXe1ti/qQAC+oZVBCrPJ2r1kEIikXHr7nyk2nqoeOaKqjvwyuYw83Y95e48KB8yfT3qnmCQSVXCK9hPthlRYdM/GPGeChBZF5m16E/lBDDBJoL08e58oSUsTMRxqdEunHxNE9s3FyTqF4wHqZX0GYyBU9RkxTTW+gpgwgk=
Message-ID: <b60ce1b70607310536y17e29fbcp8b827a17eaf98511@mail.gmail.com>
Date: Mon, 31 Jul 2006 18:06:49 +0530
From: "G SR" <gsr.lkml@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [help] Bottom half scheduling
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding Bottom half scheduling in a typical scenario.

Suppose a tasklet(bottom half) process is running and an Interrupt
occured and pre-empted the tasklet. The interrupt scheduled another
tasklet of different type.

The question is: Which tasklet will come into execution when the
interrupt task completes?. In other words whether the pre-empted
tasklet will resume its exec-
ution or the newly scheduled tasklet will execute?
