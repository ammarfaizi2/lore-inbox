Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbULUSIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbULUSIy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 13:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbULUSIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 13:08:54 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:17656 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261824AbULUSIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 13:08:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=uj/vuZW5Vz541eaDBDR0ySWpEIbjr4hmTNG2BZUJ+K8Etx0ZcXy3gAMOmEmDORDpPGk4JFdajR4/QQP052eQIqTdrh6AExk8JwwYxMgtM072FOUZKv0b/hpvFHzufmZYJN4bwHoOdJ/htIL6pk5f8jCTMkFXskRIFfbm8PucxSQ=
Message-ID: <1bdcbebf04122110087de9d976@mail.gmail.com>
Date: Tue, 21 Dec 2004 11:08:51 -0700
From: Chris Swanson <chrisjswanson@gmail.com>
Reply-To: Chris Swanson <chrisjswanson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Make changes to read-only file system using RAM
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    Has anyone seen any work done on a RAM based file system that
stores only changes to what would otherwise have been a read-only file
system?  For example, live Linux CD's rely on RAM file systems to
store directories/files that must be modified, but the majority of the
system is mounted read-only on the CD.  I was thinking it would be
really nice if we could mount a read-only medium (like a CD) in
read-write mode, and store only modifications in RAM.  This could give
the illusion of a true read-write medium, and the RAM file system
would just grow as more changes are made.
    I have searched around a bit and found nothing like this. 
Unfortunately, I have no kernel programming experience (although I'd
love to learn).  I was wondering if anyone has tried something similar
in the past.  Also, if anyone with more experience can see any reason
why this is impossible or impractical, I would love to hear it, before
I come to the same conclusion many months down the line.

Thanks for your time,
Chris
