Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVHABxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVHABxn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 21:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVHABxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 21:53:43 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:56455
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261862AbVHABxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 21:53:42 -0400
Subject: IBM HDAPS, I need a tip.
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Reply-To: abonilla@linuxwireless.org
To: linux-kernel@vger.kernel.org
Cc: "'Yani Ioannou'" <yani.ioannou@gmail.com>, Dave Hansen <dave@sr71.net>
Content-Type: text/plain
Date: Sun, 31 Jul 2005 19:53:35 -0600
Message-Id: <1122861215.11148.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

I hope you all aren't sick about the topic. I have a quick question...

Thanks to development of the driver from some nice guys, we are able to
get data from the accelerometer. There is one problem. How do we
calibrate the values that are outputed from the userspace? All PC's get
a different value, and we can't really find the best solution. What is
the scientific and smartest way to do this?

i.e. of the driver output from the userspace.
abonilla@debian:~/hdaps/hdaps-dave-0.02
$ ./ibm_hdaps_userspace /dev/ibm_hdaps 
x_accel: 409
y_accel: 528
   temp: 47
  temp2: 47
unknown: 7

If I move the PC 45 deg right.(Looking from front the left side is
higher)

km_activity (keybd) = 0
km_activity (mouse) = 0
x_accel: 396
y_accel: 579
   temp: 47
  temp2: 47
unknown: 7


The thing is, people have different values, and I think they are also
different depending on where they are.

Another question for this kernel inclusion (heh) Should we use Sysfs or
should we use the userspace that outputs this data, else what is
recomended?

Thanks in advance,

.Alejandro

