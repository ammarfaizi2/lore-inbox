Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161145AbWJ3GlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161145AbWJ3GlA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 01:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161152AbWJ3GlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 01:41:00 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:18412 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161145AbWJ3GlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 01:41:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ygi/otZYIjsPOd+EHwgh6wz06HcO9/6r9Htb+sF6dawswtKR5FCnHhPC2RjBPn95YEhU6YDYJvifcSbfydfzlMWZn0SN2eTuTId8uaaS4ZHrowmJAajmIZOvJm5IrPS2KxjGOuUl4pxNMSMDUN1WZv7Z0Z76ISAvqhHsBO38qZQ=
Message-ID: <9b33a9230610292240m68ff7652lcd9ecc1c67db7135@mail.gmail.com>
Date: Sun, 29 Oct 2006 22:40:59 -0800
From: "sudhnesh adapawar" <sudhnesh@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fork of an application with huge pages when no huge pages are left !
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all !
I am a newbie ! Recently I read a to do related huge pages on
linux-mm.org the statement being :
"Fork of an application with huge pages when no huge pages are left -
must fail over to small pages."
- Firstly,according to COW whenever the write is occured then the copy
of huge pages will start
- Now if no huge page is left we need to go for 4Kb pages....But the
application requires the huge page !
- One solution for this might be to use bunch of 4Kb pages to satisfy
the requirement....Moreover there is no demand paging or swapping
concept for huge pages !
Will this topic be feasible to go forward to....?
