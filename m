Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276889AbRJCGzf>; Wed, 3 Oct 2001 02:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276890AbRJCGzZ>; Wed, 3 Oct 2001 02:55:25 -0400
Received: from femail18.sdc1.sfba.home.com ([24.0.95.145]:63159 "EHLO
	femail18.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S276889AbRJCGzM>; Wed, 3 Oct 2001 02:55:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: linux-kernel@vger.kernel.org
Subject: Security question: "Text file busy" overwriting executables but not shared libraries?
Date: Tue, 2 Oct 2001 22:55:02 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01100222550205.02611@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anybody want to venture an opinion why overwriting executable files that are 
currently in use gives you a "text file busy" error, but overwriting shared 
libraries that are in use apparently works just fine (modulo a core dump if 
you aren't subtle about your run-time patching)?

Permissions are still enforced, but it seems to me somebody who cracks root 
on a system could potentially modify the behavior of important system daemons 
without changing their process ID numbers.

Did I miss something somewhere?

Rob
