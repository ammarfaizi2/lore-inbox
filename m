Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbWCTVId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWCTVId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWCTVIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:08:32 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:42308 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030396AbWCTVIb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:08:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gp9cXk9BThl7BDlk/qGymT4yTolqvfzHFIwELKgQsmv8vja/OEN/lL+X1xoAJ71k3z/jUvLmQGHWn3K4ekCRXYSZpk8+q+lkCA5/cy8XP+rxuvTKwSSWgm8WCYykn0jXTxA3j0Q6lzNeftVAWG17g34QIkCje5WDAiDCIcB3yVk=
Message-ID: <d1064edf0603201308v4dab8355qee1dcfc9f9b5a611@mail.gmail.com>
Date: Mon, 20 Mar 2006 13:08:30 -0800
From: "Seth Goldberg" <sethmeisterg@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: KBUILD_BASENAME hoses nvidia driver / vmware build processes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   Just an FYI -- I just grabbed 2.6.16 and installed it without a
problem.  However, when I went to rebuild the nvidia module and vmware
modules, I discovered that the lack of a definition for
KBUILD_BASENAME in linux/include/linux/spinlock.h cause these
components' builds to fail.  I added a stupid workaround and was able
to build and install these components, but I wanted to bring this to
your attention.

  Best wishes,
  ---S
