Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWFZRCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWFZRCY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWFZRBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:01:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:62173 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750868AbWFZRBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:01:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WTXNiexpaRAFI5fVnBezYD9bYqhgBEHa7MPmPjJMwnpssMukCeMIQ+lptHUWOkIyDLbjIe+mR2SUAcAMQ3PfX4wpRdYoSWpG9DBkP6e2F8tgOmn21G4Qih977TZGdq7qMQEnQs39QO+aQTLkwn3vPn4dSOiCHaEUZNXOqQGbjio=
Message-ID: <625fc13d0606261001u6841e4bcr69cf5420d7d54aec@mail.gmail.com>
Date: Mon, 26 Jun 2006 12:01:33 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Troy Benjegerdes" <hozer@hozed.org>
Subject: Re: ppc32 with CONFIG_KEXEC broken
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060626063128.GA3359@narn.hozed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060626063128.GA3359@narn.hozed.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/06, Troy Benjegerdes <hozer@hozed.org> wrote:
> various things like 'reserve_crashkernel' are referenced, but only
> exist in arch/powerpc/kernel/machine_kexec_64.c.

Can you send a patch that prevents people from turning KEXEC on when
using that arch?  The arch/ppc stuff is in a state of limbo at the
moment until it all gets migrated to arch/powerpc.

thx,
josh
