Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbUL0TjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbUL0TjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 14:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUL0TjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 14:39:10 -0500
Received: from salazar.rnl.ist.utl.pt ([193.136.164.251]:65492 "EHLO
	admin.rnl.ist.utl.pt") by vger.kernel.org with ESMTP
	id S261950AbUL0TjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 14:39:05 -0500
Message-ID: <41D064D5.1030900@rnl.ist.utl.pt>
Date: Mon, 27 Dec 2004 19:39:01 +0000
From: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] pid randomness
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi everyone,

I don't know if this has been discussed before... but I'd like to ask 
why isn't the pids randomized by default?

I mean, of course it's not required for normal functioning but it'd be 
nice to have a Kconfig option to make it happen.

The (newbie) way I see it, it'd not be hard to do... generate pid, check 
if it's unique, give pid to process. It could bring some minor security 
enhancements while taking a slight performance hit (seek & compare 
algorithm for used pids).

What are the pros and cons of this? What are your oppinions on this subjet?

regards,
pedro venda.
-- 
Pedro João Lopes Venda
email: pjvenda@rnl.ist.utl.pt
http://maxwell.rnl.ist.utl.pt

Equipa de Administração de Sistemas
Rede das Novas Licenciaturas (RNL)
Instituto Superior Técnico
http://www.rnl.ist.utl.pt
http://mega.ist.utl.pt
