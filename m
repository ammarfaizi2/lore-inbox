Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292996AbSBYRqH>; Mon, 25 Feb 2002 12:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293349AbSBYRp6>; Mon, 25 Feb 2002 12:45:58 -0500
Received: from [200.29.13.60] ([200.29.13.60]:52484 "EHLO mail.embedded.cl")
	by vger.kernel.org with ESMTP id <S292996AbSBYRpo>;
	Mon, 25 Feb 2002 12:45:44 -0500
Date: Mon, 25 Feb 2002 14:50:15 -0300
From: Carlos Manuel Duclos Vergara <carlos@embedded.cl>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: FrameBuffer Monitor Functions
Message-Id: <20020225145015.46d7c9ad.carlos@embedded.cl>
Organization: Embedded CL
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this patch is to avoid the cooking of monitors from inside the
framebuffer subsystem. Normally this would be made by
fbmon_valid_timings function, but actually this function does nothing.
So i start writing a new implementation that will make some checks, note
that is not the full answer because it requires to user use another data
structures normally don't used, but for now it checks the basic stuff.
bye



-- 
"Solo me arrepiento de unos * de menos y unos ++ de sobra"
Carlos Manuel Duclos Vergara
