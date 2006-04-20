Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWDTXnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWDTXnI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWDTXnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:43:08 -0400
Received: from mail-relay1.cs.ubc.ca ([142.103.6.79]:20684 "EHLO
	mail-relay1.cs.ubc.ca") by vger.kernel.org with ESMTP
	id S1751285AbWDTXnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:43:07 -0400
Date: Thu, 20 Apr 2006 16:43:04 -0700 (PDT)
From: Abhishek Gupta <agupta@cs.ubc.ca>
To: linux-kernel@vger.kernel.org
Subject: jbd with external device.
Message-ID: <Pine.GSO.4.60.0604201636460.5843@cascade.cs.ubc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-PMX-Version: 5.0.3.165339, Antispam-Engine: 2.1.0.0, Antispam-Data: 2006.4.20.162108
X-UBCCS-SpamTag: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I have a question with regard to using jbd (the journalling layer) apis. 
If you are using an external device then must the journal 
be located at the start of the device? I mean if I want to start the 
journal from block number 2 of a physical device then are there any 
particular initialization parameters I should watch out for?

Please advise and please CC the reply to my address as I am not subscribed 
to lkml.

many thanks,

Abhishek
