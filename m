Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWESJhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWESJhy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 05:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWESJhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 05:37:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:24512 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751323AbWESJhy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 05:37:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TLKWxazpv2xb8J+X4Utpbr0KW6AGOJPk9ODmL1fz5F5L5eU4MOcYu9k4TShQA5o1PJEH7Fe7qxCyZnSzt4tp0r+KyVOTOT3epBTDtHFSHUrs2PrqlSR1cAPuUXzFMfz7hESBnMjS0+Lw/992bighlCLTZalwY/H7E2bNG5ViNbU=
Message-ID: <e7aeb7c60605190237w3a8554adof6ec7f1ba7927ba7@mail.gmail.com>
Date: Fri, 19 May 2006 11:37:52 +0200
From: "Yitzchak Eidus" <ieidus@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: how stable are the BogoMIPS and the udelay functions on "dynamic clock speed change cpus"
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

because udelay work on the principle that it know "how much work the
cpu can do in a time" and it work by just doing a loop of nothing, how
stable is it when the cpu clock rate is keep changing all the time?
does it update its loops_per_jiffy varible each time the cpu clock is change?
or does it have another solution to this problem?
or since before the cpu enter to this udelay function it must do some
work like entering the systemcall and so on , the cpu clock rate is
jump to the original?
