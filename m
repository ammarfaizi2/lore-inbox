Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265691AbUHSLq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUHSLq3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 07:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265722AbUHSLq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 07:46:29 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:64997 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S265691AbUHSLqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 07:46:19 -0400
Subject: Re: Use global system_state to avoid system-state confusion
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@zip.com.au>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, david-b@pacbell.net
In-Reply-To: <20040819113600.GA1317@elf.ucw.cz>
References: <20040819113600.GA1317@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1092915767.19218.50.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 19 Aug 2004 21:42:48 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-08-19 at 21:36, Pavel Machek wrote:
> +		if (system_state == SYSTEM_SWSUSP_SNAPSHOT)

Would you consider getting rid of the 'SWSUSP'? It's so ugly!
SYSTEM_SNAPSHOT would be clear and concise.

Regards,

Nigel 
-- 
Nigel Cunningham
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. But true tolerance can cope with others
being intolerant.

