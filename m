Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbVLHEFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbVLHEFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 23:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbVLHEFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 23:05:33 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:9036 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751111AbVLHEFd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 23:05:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jhTsroTNQ48J8WFl16oR2VhGDD46QKFAdSxu5p2HSHiZ4QnBPDzm8ef9iLMoqE6GTH98a2tMUTINOY2FD57D/9Jli7G2bW+PwgJ0Dc6U4oRW6Lur9cbxIDXbD2jme8e0af0q7+StxlPyfYMWet5mn0uraZARKHEbp9q5LzEeics=
Message-ID: <2bd90fb70512072005y622cf7bbn53954ba6ee1fa7db@mail.gmail.com>
Date: Thu, 8 Dec 2005 09:35:31 +0530
From: "T.Krishnanand" <krishnanand.thommandra@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: diff between 'wait_event_interruptible' and 'wait_for_completion_interruptible'
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

1) whats the difference between wait_event_interruptible and
wait_for_completion_interruptible ?

2) When is one used in favour of the other ?

3) Why "might_sleep" check is ONLY for "completion" kind of sleep
routines but not for "wait" kind of sleep routines ?

thanks,
tkrishna
