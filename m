Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267181AbSKPBV5>; Fri, 15 Nov 2002 20:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267184AbSKPBV5>; Fri, 15 Nov 2002 20:21:57 -0500
Received: from adsl-64-166-42-134.dsl.scrm01.pacbell.net ([64.166.42.134]:9220
	"HELO www.wavicle.org") by vger.kernel.org with SMTP
	id <S267181AbSKPBV4>; Fri, 15 Nov 2002 20:21:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Joe Burks <jburks@wavicle.org>
Reply-To: jburks@wavicle.org
To: linux-kernel@vger.kernel.org
Subject: RE: 2.5.47 bk latest pull
Date: Fri, 15 Nov 2002 09:08:00 -0800
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021116012156Z267181-32597+23019@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had this same problem using 2.5.47bk4 from kernel.org.

I also noticed that make modules_install no longer runs depmod, so my 
module dependencies didn't get set up until I ran depmod manually which then 
exposed the QM_MODULES problem.
