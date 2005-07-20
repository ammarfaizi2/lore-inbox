Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVGTDlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVGTDlN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 23:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVGTDlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 23:41:12 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:37234 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261583AbVGTDlL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 23:41:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XIMP1+cEXrxLr+wKaOXjHHaKkY+80sPGHyF0sA98c9IRfKF8shVjvmfmiWJSHOkyXJ6vAEyQI0oRvYQzrbn/TYGYQTiU86arn8TvZsfDb6SNecZYX3EEQ8JKtBkHJVjwBKP1w0poLX0OcjqoDty2bKnWOhhMfOhkmewldZRbXYk=
Message-ID: <a71293c2050719204047bd2afe@mail.gmail.com>
Date: Tue, 19 Jul 2005 23:40:18 -0400
From: Stephen Evanchik <evanchsa@gmail.com>
Reply-To: Stephen Evanchik <evanchsa@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Subject: Synaptics and TrackPoint problems in 2.6.12
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitry,

I have been receiving a lot of complaints that TrackPoints on
Synaptics pass-thru ports stopped working with 2.6.12. I retested
2.6.9 and 2.6.11-rc3 successfully, I believe 2.6.11.7 may also work
but that is unconfirmed at this point.

The behavior is always the same .. after sending the read secondary ID
command, the TrackPoint seems to be disabled from that point forward.

Any ideas?

-- 
Stephen Evanchik
http://stephen.evanchik.com
