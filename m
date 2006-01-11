Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWAKSM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWAKSM5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWAKSM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:12:57 -0500
Received: from web34103.mail.mud.yahoo.com ([66.163.178.101]:13242 "HELO
	web34103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932422AbWAKSM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:12:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=vQEwRQHN7jtXLPOkLmY+Sa6B4CeokRAw8pHxAbAQzwGrjHG9RivRoxKR8S4In/iYXI0dTaUK0tvztoCKSBcqwhS01jC5EN4HM+dQ1tfZL7SwhmTRj6Ufzugy9wp1yB1Su8SnIxHNJ1eq67Am974Xp/uM0/CdPeNYLOzHbna5CPY=  ;
Message-ID: <20060111181252.61498.qmail@web34103.mail.mud.yahoo.com>
Date: Wed, 11 Jan 2006 10:12:52 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Is user-space AIO dead?
To: linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Having read the excellent paper by IBM presented at the 2003 OLS about Asynchronous I/O Support
in Linux 2.5, I found the conclusion rather disappointing:
"In conclusion, there appears to be no conditions for raw or O_DIRECT access under which AIO can
show a noticable benefit." - p385.
http://archive.linuxsymposium.org/ols2003/Proceedings/All-Reprints/Reprint-Pulavarty-OLS2003.pdf

Is this still the case?

If I want a transactional engine (like a database) that needs to persist to stable storage, is it
still best to use a helper thread to do write/fsync or O_SYNC|O_DIRECT?

-Kenny


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
