Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUCYPCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 10:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263186AbUCYPCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 10:02:42 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:25772 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S263184AbUCYPCk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 10:02:40 -0500
Date: Thu, 25 Mar 2004 16:02:24 +0100
From: Marc Lehmann <pcg@schmorp.de>
To: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Cc: Cameron Patrick <cameron@patrick.wattle.id.au>,
       Michael Frank <mhf@linuxmail.org>, Pavel Machek <pavel@suse.cz>,
       Software Suspend - Mailing Lists 
	<swsusp-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] lzf license
Message-ID: <20040325150224.GC11633@schmorp.de>
Mail-Followup-To: Arjan van de Ven <arjanv@redhat.com>,
	linux-kernel@vger.kernel.org,
	Cameron Patrick <cameron@patrick.wattle.id.au>,
	Michael Frank <mhf@linuxmail.org>, Pavel Machek <pavel@suse.cz>,
	Software Suspend - Mailing Lists <swsusp-devel@lists.sourceforge.net>
References: <opr49atvpk4evsfm@smtp.pacific.net.th> <20040322094053.GO16890@patrick.wattle.id.au> <1079948988.5296.8.camel@laptop.fenrus.com> <20040322182121.GA21521@schmorp.de> <20040323114725.GD13666@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323114725.GD13666@devserv.devel.redhat.com>
X-Operating-System: Linux version 2.6.4 (root@cerebro) (gcc version 3.3.3 20040125 (prerelease) (Debian)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 12:47:26PM +0100, Arjan van de Ven <arjanv@redhat.com> wrote:
> About bugfixes; I'd recommend using something like:

That sounds reasonable. Sorry for the delay, but I didn't receive your
mail earlier (not being on the cc:).

I have added this notice to all core files of the distribution and
released it as 1.3, assuming that this solves all the problems. It can
temporarily be found here: http://data.plan9.de/liblzf-1.3.tar.gz

The files in the kernel diverge a tiny bit (being a slight subset), and I
think it's easiest to just add the additional notice to the files:

   kernel/power/lzf/lzf_c.c
   kernel/power/lzf/lzf_d.c

The following should be applied to both files:

diff -u -p
@@ -24,6 +24,16 @@
  * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTH-
  * ERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
  * OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * Alternatively, the contents of this file may be used under the terms of
+ * the GNU General Public License version 2 (the "GPL"), in which case the
+ * provisions of the GPL are applicable instead of the above. If you wish to
+ * allow the use of your version of this file only under the terms of the
+ * GPL and not to allow others to use your version of this file under the
+ * BSD license, indicate your decision by deleting the provisions above and
+ * replace them with the notice and other provisions required by the GPL. If
+ * you do not delete the provisions above, a recipient may use your version
+ * of this file under either the BSD or the GPL.
  */



-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
