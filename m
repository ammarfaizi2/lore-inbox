Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132671AbQK3Hpn>; Thu, 30 Nov 2000 02:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132656AbQK3HpY>; Thu, 30 Nov 2000 02:45:24 -0500
Received: from mail.linux.student.kuleuven.ac.be ([193.190.253.82]:55300 "EHLO
        mail.linux.student.kuleuven.ac.be") by vger.kernel.org with ESMTP
        id <S132259AbQK3HpM>; Thu, 30 Nov 2000 02:45:12 -0500
Date: Thu, 30 Nov 2000 08:14:43 +0100
From: Arnaud Installe <arnaud@bach.kotnet.org>
To: linux-kernel@vger.kernel.org
Cc: ainstalle@filepool.com
Subject: high load & poor interactivity on fast thread creation
Message-ID: <20001130081443.A8118@bach.iverlek.kotnet.org>
Reply-To: Arnaud Installe <a.installe@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When creating a lot of Java threads per second linux slows down to a
crawl.  I don't think this happens on NT, probably because NT doesn't
create new threads as fast as Linux does.

Is there a way (setting ?) to solve this problem ?  Rate-limit the number
of threads created ?  The problem occurred on linux 2.2, IBM Java 1.1.8.

Thanks,

							Arnaud

-- 
Arnaud Installe                                             a.installe@ieee.org

Look, we trade every day out there with hustlers, deal-makers, shysters,
con-men.  That's the way businesses get started.  That's the way this
country was built.
		-- Hubert Allen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
