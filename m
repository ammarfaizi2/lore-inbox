Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVC0SEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVC0SEh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 13:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVC0SEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 13:04:37 -0500
Received: from mta6.srv.hcvlny.cv.net ([167.206.4.201]:15610 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261269AbVC0SEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 13:04:32 -0500
Date: Sun, 27 Mar 2005 13:04:31 -0500
From: Nick Orlov <bugfixer@list.ru>
Subject: 2.6.12-rc1-mm3: class_simple API
To: linux-kernel@vger.kernel.org
Mail-followup-to: linux-kernel@vger.kernel.org
Message-id: <20050327180431.GA4327@nikolas.hn.org>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm really sorry for bringing such a "flame-creative" topic to the list,
but Greg asked me to do so after a short discussion in private.

Problem is that the latest bk-driver-core patch included in the 2.6.12-rc1-mm3
removes class_simple API without providing EXPORT_SYMBOL'ed (as opposed to
EXPORT_SYMBOL_GPL) alternative.

As the result I don't see a way how out-of-the-kernel non-GPL drivers
(nvidia in my case) could be fixed.

So, basically the questions are:

 - Whether the changes like the one above are "the right thing to do" ?
 - What's the best way to deal with this particular issue ?


P.S. Please CC me, I'm not subscribed to the list.

-- 
With best wishes,
	Nick Orlov.

