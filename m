Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWFXNg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWFXNg1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 09:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWFXNg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 09:36:27 -0400
Received: from [80.96.155.2] ([80.96.155.2]:49874 "EHLO aladin.ro")
	by vger.kernel.org with ESMTP id S964835AbWFXNg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 09:36:27 -0400
Message-ID: <449D6AD4.70202@aladin.ro>
Date: Sat, 24 Jun 2006 16:39:48 +0000
From: Eduard-Gabriel Munteanu <maxdamage@aladin.ro>
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Structure versioning
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*This message was transferred with a trial version of CommuniGate(r) Pro*
Wouldn't it be nice to keep a record of structs' revisions within 
themselves? This might allow for very fast kernel update (if nothing 
important hasn't changed between the two versions) with almost no 
downtime. swsusp's state savers maybe aren't enough, but we can reuse 
some code.
