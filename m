Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWJCO3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWJCO3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 10:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWJCO3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 10:29:04 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:30754 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932257AbWJCO3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 10:29:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Kdw98Yrf8DuGtJgnpORDGBOlA7TX3/uxKTiJJegCamVs9BbZGU2fhixuJKGDWWTb3TFymzbU1FvauhvPXInhbQG5YXRHCm6SDVgnzah8br+SPNeoqwXvhU8/sSRd9Q0B/2or+X/8WRq0m0l7JJxeI7rUafsbJcr04xS35hhGrzY=
Message-ID: <20f65d530610030729o42658bd6hcc204f8deac4a33e@mail.gmail.com>
Date: Wed, 4 Oct 2006 03:29:02 +1300
From: "Keith Chew" <keith.chew@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: BIOS THRM-Throttling and driver timings
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

We have a motherboard that has Thermal Throttling in the BIOS (which
we cannot disable). This causes the CPU usage to go up and down when
the CPU temperature reaches (and stays around) the Throttling
temperature point.

What we would like to know is whether this will affect the timings in
drivers, eg the wireless drivers we are using. What can we check in
drivers' code that will tell us that its operations may be affected
the throttling?

In the past few days, we noticed that some of the linux units we
deployed freezes after deveral hours of operation, we are now trying
to reproduce the problem in our test environment. Some insight on the
affect of throttling will help us narrow down the search.

Regards
Keith
