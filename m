Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937765AbWLFXDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937765AbWLFXDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 18:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937766AbWLFXDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 18:03:52 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:6434 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S937765AbWLFXDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 18:03:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hOPql7QHnoZQPmjMIornDUgPZkqeXBTnrX+lwe2pGGvbtIzWtWTDUIH9KNyK7Vtlh1E/vTDfX0voBl2NN3Bmj+9BHzzbuW/Z/2sGqdiZEmLTH4as7znnlqMwwEagIXGo290NAroreWOZojXRp1Sg2+DGP2NqJ7ZUJpc3glI5i8Y=
Message-ID: <8bd0f97a0612061503u4318c299ja0e06b30509ca34d@mail.gmail.com>
Date: Wed, 6 Dec 2006 18:03:50 -0500
From: "Mike Frysinger" <vapier.adi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: usage of linux/types.h wrt to install_headers
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there are a plethora of headers that cannot be included straight due
to the usage of __ types (like __u32) without first including
linux/types.h ... so the question is, should all of these headers be
fixed to properly pull in linux/types.h first or are users expected to
"just know" the correct order of headers ?  in my mind, pretty much
every header is fair game for straight "#include <header>" usage and
requiring a list of headers to be pulled in properly is ignoring the
problem ...
-mike
